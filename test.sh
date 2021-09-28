curl -s 'https://api.github.com/users/lambda' | jq -r '.name'

curl -s 'https://api.github.com/repos/rshnGhost/django-quick/commits' | jq -r '.sha'

curl -s 'http://twitter.com/users/username.json' | sed -e 's/[{}]/''/g' | awk -v RS=',"' -F: '/^text/ {print $2}'
