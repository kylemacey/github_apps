Rails.application.routes.draw do
  mount GithubApps::Engine => "/github_apps"
end
