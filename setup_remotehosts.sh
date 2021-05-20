CMD='cd /home/dadriaan/git/dadriaan-dotfiles; /home/dadriaan/git/dadriaan-dotfiles/setup.sh'

function setup_host() {

  echo ssh -Y ${USER}@$1.rap.ucar.edu \'${CMD}\'
  ssh -Y ${USER}@$1.rap.ucar.edu ${CMD}
  
}

host_list=("cessna" "khaba" "radia" "nikara" "sonbef" "ahmose" "horus" "huni" "djoser" "dakota" "doohan" "etage" "eyewall" "floyd"\
             "grebe" "kiowa" "mizu" "raneb" "tuvok" "content" "bowie" "aoaws10")

for h in ${host_list[@]}; do
  setup_host ${h}
done

