
IF "%1" == "" (
    SET url="http://localhost"
) ELSE IF "%1" == "deploy" (
    SET url=https://nolleh.github.io
)

hugo server --baseUrl=%url% --destination=public/ --port=80 --appendPort=false