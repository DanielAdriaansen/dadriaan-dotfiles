CMD='cd ~/git/dadriaan-dotfiles; git pull origin main'

function update_host() {

  echo ssh -Y ${USER}@$1.rap.ucar.edu \'${CMD}\'
  ssh -Y ${USER}@$1.rap.ucar.edu ${CMD}
  
}

host_list=("cessna" "khaba" "radia" "nikara" "sonbef" "ahmose" "horus" "huni" "djoser" "dakota" "doohan" "etage" "eyewall" "floyd"\
             "grebe" "kiowa" "mizu" "raneb" "tuvok" "content" "bowie" "aoaws10")

for h in ${host_list[@]}; do
  update_host ${h}
done

