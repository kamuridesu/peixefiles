function set_project_env -d "Autoload project env"
    if test -f "./.sdkmanrc"
        sdk env
        return
    end
    if test -f "./.nvmrc"
        nvm use
        return
    end
end
