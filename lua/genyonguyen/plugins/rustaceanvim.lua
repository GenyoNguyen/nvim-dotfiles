return {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    build = "rustup component add rust-analyzer",
    ft = {"rust"},
    lazy = false,
}
