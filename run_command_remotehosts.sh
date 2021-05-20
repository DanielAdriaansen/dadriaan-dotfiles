CMD='cd ~/git/dadriaan-dotfiles; git remote set-url origin git@github.com:NCAR/dadriaan-dotfiles.git'
#CMD='mv ~/git/dotfiles ~/git/dadriaan-dotfiles'
#CMD='cd ~/git/dadriaan-dotfiles; git remote -v'

function run_command() {

  echo ssh -Y ${USER}@$1.rap.ucar.edu \'${CMD}\'
  ssh -Y ${USER}@$1.rap.ucar.edu ${CMD}
  
}

host_list=("cessna" "khaba" "radia" "nikara" "sonbef" "ahmose" "horus" "huni" "djoser" "dakota" "doohan" "etage" "eyewall" "floyd"\
             "grebe" "kiowa" "mizu" "raneb" "tuvok" "content" "bowie" "aoaws10")

for h in ${host_list[@]}; do
  run_command ${h}
done

