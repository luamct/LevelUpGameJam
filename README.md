# GameTemplate

Custom Godot game template, with CICD to itch.io.

* Use this template to [create a new repo](https://github.com/new?template_name=gametemplate&template_owner=comigor);
* Generate an [itch.io API Key](https://itch.io/user/settings/api-keys);
* Add it as a new `BUTLER_API_KEY` secret [on your repo](settings/secrets/actions/new);
* Configure the `[env]` variables on [deploy.yaml](blob/master/.github/workflows/deploy.yaml) (`ITCH_USERNAME`, `ITCH_PROJECT_NAME` and `GODOT_VERSION`);

CI was automatic but that was spending too much free GitHub resources. Now this process is manual and [can be triggered here](actions/workflows/deploy.yaml) (click on "Run workflow" button).
If you want to make it automatic again, uncomment the `[on push]` key on [deploy.yaml](blob/master/.github/workflows/deploy.yaml).
