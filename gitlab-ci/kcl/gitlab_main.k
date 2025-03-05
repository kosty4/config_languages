import .gitlab_module  # A relative path import


gitlab_module.GitlabCI {
    stages = ["build", "test", "deploy"]
    
    default = {
        image : "node"
    }

    ".standard-rules" : gitlab_module.HiddenStage {
            rules = [
                {
                    "if": "$CI_PIPELINE_SOURCE == 'merge_request_event'"
                },
                {
                    "if": "$CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH"
                }
            ]
        }

    jobs = {
        "build-job": gitlab_module.Stage {
            stage = "build",
            script = ["npm install", "npm run build"]
        },
        "lint-markdown": gitlab_module.Stage {
            stage = "test",
            script = ["npm install markdownlint-cli2 --global", "markdownlint-cli2 -v", "markdownlint-cli2 'blog/**/*.md' 'docs/**/*.md'"]
            allow_failure= "true"
        },
        "test-html": gitlab_module.Stage {
            stage = "test"
            script = ["npm install --save-dev htmlhint", "npx htmlhint --version", "npx htmlhint build/"]
            artifacts = gitlab_module.ArtifactPaths {paths: ["build/"]}
            dependencies = ["build-job"]

        },
        "pages": gitlab_module.Stage {
            extends = []
            stage = "deploy"
            image = "busybox"
            script = ["mv build/ public/"]
            artifacts = gitlab_module.ArtifactPaths {paths: ["public/"]}
            dependencies = ["build-job"]
            rules = [{
                    "if": "$CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH"
                }]
        },
    }
}
