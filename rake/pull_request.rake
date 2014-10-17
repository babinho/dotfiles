desc "Pushes current branch, checks out the one you want to make a pull request, pulls it and goes back to first branch"
task :pr, [:target_branch] do |t, args|
  target_branch = args[:target_branch] || 'master'
  pull_request(target_branch)
end

task :pr_staging do
  puts ENV['RUBY_VERSION']
  pull_request('staging')
end

def pull_request(target_branch = 'master')
  current_branch = %x{git rev-parse --abbrev-ref HEAD}
  system("git push -u")
  system("git checkout #{target_branch}")
  system("git pull --rebase")
  system("git checkout #{current_branch}")
  Bundler.with_clean_env do
    system("hub pull-request -b #{target_branch}")
  end
end
