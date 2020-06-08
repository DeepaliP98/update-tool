#!/bin/bash


ORIGIN=$(git config --get remote.origin.url)
UPSTREAM==$(git config --get remote.upstream.url)

upstream() {
	echo -e "Enter the URL of the original repo: \c"
	read REPO

	echo "Let's add upstream to your local repo as a remote."
	git remote add upstream $REPO
	sleep 2
	echo "Remote upstream set."

}

if (git remote show | grep -q upstream)
then
	echo "Upstream URL: $UPSTREAM ";
else
	echo "Upstream is not added.";
	echo "Let us set upstream first."
	read -p "Press Y to add, N to skip" yn
	case $yn in
        [Yy]* ) upstream; ;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
fi

update() {
	echo "Updating ..."
	git pull upstream master
	git push $ORIGIN master

}

push() {
	sleep 1
	echo "Pushing ..."
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
options=("Update" "Push" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Update")
					update
					;;
        "Push")
            push
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
