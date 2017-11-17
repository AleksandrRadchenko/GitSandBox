# Set remote name
remote=origin
# Make sure we have updated master
git checkout master
git pull
# For every branch except master
for brname in `git branch -r | grep $remote | grep -v master | awk '{gsub(/^[^\/]+\//,"",$1); print $1}'`
do
  # Create branch or just checkout
  git checkout $brname
  # In case branch changed by someone else
  git pull
  # Resolve conflicts in favor of master branch
  git merge -Xtheirs -m "Merge branch 'master' into $brname" master
  git push
done
