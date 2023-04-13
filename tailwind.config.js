module.exports = {
  theme: {
    extend: {
      colors: {
        // 'カラー名': 'カラーコード'
        "line-green": "#06C755",
        "hover-line-green": "#06C755",
      },
    },
  },
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
};
