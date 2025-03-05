#  --- define the schema here ---

schema DefaultConfig:
    [...str]: str

schema Rule:
    "if" : str

schema ArtifactPaths:
    paths: [str]

schema Stage:

    extends?: [str] = [".standard-rules"]
    stage: str
    image?: str
    script: [str]
    artifacts? : ArtifactPaths
    dependencies? : [str]
    rules? : [Rule]
    [...str] : str

schema HiddenStage:
    rules: [Rule]

schema GitlabCI:
    stages: [str]
    default?: DefaultConfig
    [...str] : HiddenStage
    jobs: {str: Stage}
    # jobs: {str: Stage | HiddenStage} 