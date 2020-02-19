// config/webpack/environment.js
const { environment } = require('@rails/webpacker');
const webpack = require('webpack');

// Add an additional plugin of your choosing : ProvidePlugin
environment.plugins.append(
    'Provide',
    new webpack.ProvidePlugin({
        //$: 'jquery',
        //jQuery: 'jquery',
        //'window.jQuery': 'jquery',
        Popper: ['popper.js', 'default'],
        'window.moment': 'moment',
        moment: 'moment',
        Raphael: 'raphael' // required by morris.js
    })
);

// Enable the default config
// environment.splitChunks()
environment.splitChunks(config =>
    Object.assign({}, config, {
        optimization: {
            splitChunks: {
                cacheGroups: {
                    commons: {
                        test: /[\\/]node_modules[\\/]/,
                        // name: VENDOR_CHUNK_NAME,
                        chunks: 'all',
                        minChunks: 2
                    }
                }
            }
        }
    })
);

// Fix for flot resize
const flotResizeLoader = {
    test: /jquery\.flot\.resize\.js$/,
    use: ['imports-loader?this=>window']
};
environment.loaders.prepend('flotresize', flotResizeLoader);

module.exports = environment;
