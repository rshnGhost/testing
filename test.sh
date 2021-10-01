packagesNeeded='curl jq'
if [ -x "$(command -v apk)" ];       then sudo apk add --no-cache $packagesNeeded
elif [ -x "$(command -v apt-get)" ]; then sudo apt-get install $packagesNeeded
elif [ -x "$(command -v dnf)" ];     then sudo dnf install $packagesNeeded
elif [ -x "$(command -v zypper)" ];  then sudo zypper install $packagesNeeded
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: $packagesNeeded">&2;fi

sha = curl -s 'https://api.github.com/repos/rshnGhost/django-quick/commits' | jq -r '.[0].sha' | cut -c1-7
echo "rshn"
echo sha
