module.exports = {
  root: true,
  parser: 'babel-eslint',
  parserOptions: {
    sourceType: 'module'
  },
  env: {
      browser: true
  },
  extends: 'eslint:recommended',
  globals: {
      process: true
  },
  plugins: [
    'html'
  ],
  rules: {
    'no-debugger': process.env.NODE_ENV === 'production' ? 2 : 0,
    'no-console': process.env.NODE_ENV === 'production' ? 2 : 0,
    'array-callback-return': 2
  }
}
