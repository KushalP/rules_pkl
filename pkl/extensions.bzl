load("//pkl:repositories.bzl", "pkl_cli_binaries")
load("//pkl/private:pkl_deps.bzl", "parse_pkl_project_deps_json", "pkl_deps")
load("//pkl/private:remote_pkl_package.bzl", "remote_pkl_package")

pkl_project = tag_class(
    attrs = {
        "name": attr.string(
            doc = "Name of the workspace to generate",
        ),
        "pkl_project": attr.label(
            doc = "The PklProject file",
            allow_single_file = True,
            mandatory = True,
        ),
        "pkl_project_deps": attr.label(
            doc = "The PklProject.deps.json file",
            allow_single_file = True,
            mandatory = True,
        ),
    },
)

def _toolchain_extension(module_ctx):
    pkl_cli_binaries()

    workspaces = []
    for mod in module_ctx.modules:
        for proj in mod.tags.project:
            if proj.name in workspaces:
                fail("May only declare workspace with name %s once." % proj.name)
            workspaces.append(proj.name)

            # Make sure all the remote files are downloaded and unpacked
            packages = parse_pkl_project_deps_json(module_ctx.read(proj.pkl_project_deps))
            for package in packages:
                remote_pkl_package(
                    name = package.workspace_name,
                    url = package.url,
                    sha256 = package.sha256,
                )

            # Now set up all the targets that people will rely on in their builds.
            pkl_deps(
                name = proj.name,
                pkl_project = proj.pkl_project,
                pkl_project_deps = proj.pkl_project_deps,
            )

pkl = module_extension(
    implementation = _toolchain_extension,
    tag_classes = {
        "project": pkl_project,
    },
)
