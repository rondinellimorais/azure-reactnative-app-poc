lane :package_json_version do
  JSON.parse(File.read('../package.json'))["version"]
end