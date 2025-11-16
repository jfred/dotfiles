-- Language-specific plugins
return {
  -- Go
  { "fatih/vim-go", ft = "go" },

  -- Java
  { "hdiniz/vim-gradle" },
  { "tpope/vim-classpath", ft = "java" },
  { "mfussenegger/nvim-jdtls", ft = "java" },

  -- Clojure
  { "tpope/vim-fireplace", ft = "clojure" },

  -- Ruby/Rails
  { "slim-template/vim-slim", ft = "ruby" },
  { "tpope/vim-rails", ft = "rails" },

  -- Python/Django
  { "tweekmonster/django-plus.vim", ft = { "python", "htmldjango" } },

  -- Docker
  { "ekalinin/Dockerfile.vim", ft = "dockerfile" },

  -- Elixir/Erlang
  { "elixir-lang/vim-elixir", ft = "erlang" },

  -- JavaScript/TypeScript
  { "pangloss/vim-javascript", ft = "javascript" },
  { "leafgarland/typescript-vim", ft = "typescript" },
}
