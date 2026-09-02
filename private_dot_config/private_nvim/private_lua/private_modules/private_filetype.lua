vim.filetype.add({
  -- 1. Match by file extension
  -- extension = {
  --   mdx = 'markdown',
  --   env = 'sh',
  --   config = 'toml',
  -- },

  -- 2. Match by exact filename
  filename = {
    ['vifmrc'] = 'vim',
    -- ['Jenkinsfile'] = 'groovy',
  },

  -- 3. Match by pattern (regex/path matching)
  -- pattern = {
    -- Matches paths containing 'nginx' and ending in '.conf'
    -- ['.*/nginx/.*%.conf'] = 'nginx',
    
    -- Matches files like '.bash_profile_local'
    -- ['%.bash_profile_.*'] = 'sh',
  -- },
})


