function tf --description "opentofu wrapper with notification support"
    tofu $argv && notify-send -a Terraform Terraform OK && return 0 || notify-send -a Terraform Fail && return 1
end

function set_project_env -d "Autoload project env"
    if test -f "./.sdkmanrc"
        sdk env
        return
    end
end
