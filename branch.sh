#!/bin/bash


ORIGIN=$(git config --get remote.origin.url)
UPSTREAM==$(git config --get remote.upstream.url)

if (git remote show | grep -q upstream)
then
	echo "Upstream URL: $UPSTREAM ";
else
	echo "Upstream is not added.";
fi


update() {
	echo "Updating ..."
	git pull upstream master
	git push $ORIGIN master

}
other() {
	echo "This program will help you add your changes to git."
	echo -e "Enter the URL of the original repo: \c"
	read REPO

	echo "Perfect. Now, let's add it to your local repo as a remote."
	git remote add upstream $REPO

	echo "Done. Now, let's get a branch made for you."
	echo -e "Enter the name of the branch you want to create: \c"
	read BRANCH
	echo "Checking out to that branch ..."
	git checkout $BRANCH

}
