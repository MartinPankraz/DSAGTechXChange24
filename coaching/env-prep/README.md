# Preparing the coaching environment

- Create a copy of `env.sh.template` as `env.sh`.
- Replace values in your `env.sh`.
- Register required resource provides with `register_rps.sh`
- Create users with `provision_users.sh`. (Note: Users will be disabled by default; change the parameter in `az ad user update` if required).