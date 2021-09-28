curl -s 'https://api.github.com/users/lambda' | fx .sha
curl -s 'https://api.github.com/repos/rshnGhost/django-quick/commits' | fx .sha
curl -s 'https://api.github.com/repos/rshnGhost/django-quick/commits' | jq -r .sha
echo "rshn"
