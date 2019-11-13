# デプロイしたいディレクトリの場所
deploy_path=~/neovim

# リモートリポジトリのURL
remote_path=https://github.com/neovim/neovim

# デプロイするブランチ
branch=master

cd ${deploy_path}

# プロジェクトのディレクトリがあるか確認
# なければclone、あればpullをおこなう
if [ ! -e ${proj_name} ]; then
    git clone ${remote_path} ${proj_name}
    echo 'cloning success!'
else
    # pullもしくはfetch＆reset --hardを使う
    # 競合を起こさないよう、強制的に最新のリモートリポジトリに合わせる
    # pullもしくはfetch＆reset --hardを使う
    # 競合を起こさないよう、強制的に最新のリモートリポジトリに合わせる
    result=`sudo git pull origin ${branch}`
    if [ "`echo $result | grep 'Already'`" ]; then
        echo 'Already up to date'
        echo 'finish'
    else
        echo 'git pull is success!'
        # build
        cd ~/neovim
        sudo rm -rf ~/neovim/build
        sudo make CMAKE_BUILD_TYPE=Release
        sudo make install
        echo 'build done!'
    fi
fi


