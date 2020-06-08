#!/bin/bash


ORIGIN=$(git config --get remote.origin.url)
UPSTREAM==$(git config --get remote.upstream.url)

if (git remote show | grep -q upstream)
then
	echo "Upstream URL: $UPSTREAM ";
else
	echo "Upstream is not added.";
	echo "Let us set upstream first."
	upstream
fi

upstream() {
	echo -e "Enter the URL of the original repo: \c"
	read REPO

	echo "Let's add upstream to your local repo as a remote."
	git remote add upstream $REPO
	sleep 2
	echo "Remote upstream set."

}

update() {
	echo "Updating ..."
	git pull upstream master
	git push $ORIGIN master

}

feature() {
	echo "Done. Now, let's get a branch made for you."
	echo -e "Enter the name of the branch you want to create: \c"
	read BRANCH
	echo "Checking out to that branch ..."
	git checkout $BRANCH

}


PS3='Please enter your choice: '
options=("Update" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Update")
					update
					;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Option 3")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
