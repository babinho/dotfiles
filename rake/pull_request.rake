desc "Pushes current branch, checks out the one you want to make a pull request, pulls it and goes back to first branch"
task :pull_request, [:target_branch] do |t, args|
  target_branch = args[:target_branch] || 'master'
  current_branch = %x{git rev-parse --abbrev-ref HEAD}
  system("git push -u")
  system("git checkout #{target_branch}")
  system("git pull --rebase")
  system("git checkout #{current_branch}")
  system("hub pull-request -b #{target_branch}")
end
