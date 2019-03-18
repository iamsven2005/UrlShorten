let app = new Vue({
    el: '#app',
    data: {
        message: 'Type your URL to be shortened here..'
    },

    methods: {
        post: function (event) {
            const url = '/api/shorten/new'
            let req = 'https://freecodecamp.com'

            fetch(url, {
                method: "POST",
                headers: new Headers({
                    'Content-Type':'application/x-www-form-urlencoded',
    }),
                body: `long-url=fire`
            })
        }
    }})
