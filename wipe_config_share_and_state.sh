
share_path='~/.local/share/'
state_path='~/.local/state/'


#get input from the usero
echo "Enter name of the setup"
read name_of_setup

confirm='no'
echo "This will delete the dirs: "
echo "$share_path$name_of_setup"
echo "$state_path$name_of_setup"
echo "This can not be undone"
echo "Do you want to continue? (yes/no)"
#read confirm and make it uppercase
read confirm
confirm_u=$(echo $confirm | tr '[:lower:]' '[:upper:]')
if [ "$confirm_u" = 'YES' ]; then
    echo "Removing: $share_path$name_of_setup"
    rm -rf $share_path$name_of_setup
    echo "Removing: $state_path$name_of_setup"
    rm -rf $state_path$name_of_setup
else
    echo "You have chosen to exit"
    exit 1
fi

