CMD='cd ~/git/dotfiles; git pull origin master'

function update_host() {

  echo ssh -Y ${USER}@$1.rap.ucar.edu \'${CMD}\'
  ssh -Y ${USER}@$1.rap.ucar.edu ${CMD}
  
}

host_list=("cessna" "khaba" "radia" "nikara" "sonbef" "ahmose" "horus" "huni" "djoser" "dakota" "doohan" "etage" "eyewall" "floyd"\
             "grebe" "kiowa" "mizu" "raneb" "tuvok" "content")

for h in ${host_list[@]}; do
  update_host ${h}
done

