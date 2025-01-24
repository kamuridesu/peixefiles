
function set_project_env -d "Autoload project env"
    if test -f "./.sdkmanrc"
        sdk env
        return
    end
end
