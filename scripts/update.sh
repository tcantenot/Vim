# Update all vim's submodules

cd ..
git submodule foreach git pull origin master

#cd bundle
#for dir in $(find ./ -mindepth 1 -maxdepth 1 -type d);do
    #cd $dir
    #echo $(pwd)
    #git submodule update --recursive
    #cd ..
#done
