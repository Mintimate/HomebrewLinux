if [ `id -u` -eq 0 ];then
    echo '\033[1;31m请勿使用root用户安装Homebrew \033[0m'
    exit 0
elif [ `uname -m` != 'x86_64' ];then
    ehco '\033[1;31mLinux的Homebrew暂时不支持非x86_x64设备 \033[0m'
    exit 0
elif [ `uname` = "Darwin" ];then
    echo '\033[1;31m
    本Homebrew安装脚本为Linux版本，macOS用户请查看：
        https://www.mintimate.cn/2020/04/05/Homebrew
     \033[0m'
    exit 0
fi

echo '
033[1;32m开始执行Brew自动安装程序\033[0m
\033[1;36m_____________________________________________________________\033[0m
\033[1;36m    _   _\033[0m
\033[1;36m    /  /|     ,                 ,\033[0m
\033[1;36m---/| /-|----------__---_/_---------_--_-----__---_/_-----__-\033[0m
\033[1;36m  / |/  |   /    /   )  /     /    / /  )  /   )  /     /___)\033[0m
\033[1;36m_/__/___|__/____/___/__(_ ___/____/_/__/__(___(__(_ ___(___ _\033[0m
\033[1;36m         Mintimate’s Blog:https://www.mintimate.cn \033[0m
\033[1;36m_____________________________________________________________\033[0m
              \033[1;36m作者：Mintimate\033[0m'
#选择一个下载源
echo '\033[1;32m
请选择一个下载镜像，例如中科大，输入1回车。
\033[1;33m 1、腾讯云源(适用于大陆设备)  2、官方下载源(适用于非大陆设备) \033[0m'
read "MY_DOWN_NUM?请输入序号: "
if [[ "$MY_DOWN_NUM" -eq "2" ]];then
  echo "你选择了官方下载源"
  #HomeBrew基础框架
  USER_BREW_GIT=https://github.com/Homebrew/brew.git
  #HomeBrew Core
  USER_CORE_GIT=https://github.com/Homebrew/linuxbrew-core.git

else
  echo "你选择了腾讯云源"
  #HomeBrew基础框架
  USER_BREW_GIT=https://mirrors.cloud.tencent.com/homebrew/brew.git
  #HomeBrew Core
  USER_CORE_GIT=https://mirrors.cloud.tencent.com/homebrew/linuxbrew-core.git
fi

echo '==> 进入用户目录并创建Homebrew文件目录'
cd /home
sudo mkdir linuxbrew
cd linuxbrew
sudo mkdir .linuxbrew
sudo chown -R $(whoami) .linuxbrew
cd .linuxbrew
echo '==> 克隆Homebrew基础框架'
git clone $USER_BREW_GIT Homebrew
echo '==> 创建软链'
mkdir bin
ln -s /home/linuxbrew/.linuxbrew/Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin
echo '==> 进入Homebrew目录创建Core核心文件'
cd Homebrew/Library
mkdir -p Taps
cd Taps
mkdir homebrew
cd homebrew
echo '==> 克隆Homebrew核心框架'
git clone $USER_CORE_GIT homebrew-core
echo '==> 克隆完成'
echo '==> Homebrew安装完成，请手动添加到环境变量：'

echo "
    \033[1;32m添加环境变量\033[0m
    使用Bash用户（默认）：
    添加：
    export HOMEBREW_BOTTLE_DOMAIN=\"https://mirrors.ustc.edu.cn/linuxbrew-bottles\"
    eval \$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    到：~/.profile

    使用ZSH用户：
    添加：
    export HOMEBREW_BOTTLE_DOMAIN=\"https://mirrors.ustc.edu.cn/linuxbrew-bottles\"
    eval \$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    到：~/.zshrc"
