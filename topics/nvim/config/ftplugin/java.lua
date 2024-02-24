local config = {
    cmd = {'/opt/homebrew/Cellar/jdtls/1.33.0/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)
