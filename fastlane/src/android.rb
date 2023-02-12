platform :android do
  # ======= PUBLIC
  lane :setup do | options |
    sh "echo \"yarn reset\"; \
        yarn setup #{ENV['AIRFOX_ENVIRONMENT_NAME']}; \
        yarn environment #{ENV['AIRFOX_ENVIRONMENT_NAME']};"
  end

  lane :build do | options |
    # setup()
    android_set_version_name(
      version_name: package_json_version,
      gradle_file: "./android/app/build.gradle"
    )
    android_set_version_code(
      version_code: options[:version_code] || 600,
      gradle_file: "./android/app/build.gradle"
    )
    if options[:env] == "sandbox"
      build_sandbox()
    elsif options[:env] == "production"
      build_production()
    else
      puts "[ERROR] fastlane [ios|android] build --env [sandbox|production]"
    end
  end

  # ======= PRIVATE
  # DO NOT CALL THESE FUNCTIONS DIRECTLY
  lane :build_sandbox do | options |
    gradle(task: "app:assembleRelease", project_dir: "android/")
  end

  lane :build_production do | options |
    # gradle(task: "app:assembleProductionRelease", project_dir: "android/")
    # gradle(task: "app:bundleProductionRelease", project_dir: "android/")
  end

  lane :apply_appdome do | options |
    # ....
    # envia o apk e recebe
    # envia o aab e recebe
  end

  lane :deploy do | options |
    puts "deploy..."
    # sandbox
    # enviar o apk p algum lugar

    # production
    # build_production --> irá gerar o apk de prod utilizando as envs de prod e assinatura de prod
    # envs do appdome
    # enviar apk para o appdome
    # receber o apk
    # reassinar
    # enviar o apk p algum lugar
  end
end