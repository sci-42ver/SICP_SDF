# https://www.freecodecamp.org/news/bash-array-how-to-declare-an-array-of-strings-in-a-bash-script/
myArray=("6.945_assignment_solution" "sdf_mbillingr" "chebert_software-design-for-flexibility" "SDF_exercises" "SICP")
for str in ${myArray[@]}; do
  echo ">>> In $str dir"
  # https://stackoverflow.com/a/10931620/21294350 submodule first
  cd ~/SICP_SDF/$str
  # https://stackoverflow.com/a/1983070/21294350
  git add -A;git commit -m "$1";git push
done
cd ..
git add -A;git commit -m "$1";git push
