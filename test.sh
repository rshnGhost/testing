curl -sS https://webinstall.dev/jq | bash
curl -s 'https://api.github.com/users/lambda' | jq -r '.name'

curl -s 'https://api.github.com/repos/rshnGhost/django-quick/commits' | jq -r '.sha'

