let app = new Vue({
    el: '#app',
    data: {
        input: '',
    },

    methods: {
        post: function (event) {
            const url = '/api/shorten/new'
            const orig = this.input
            let formData = new URLSearchParams()
            
            formData.append('long-url', orig)

            return fetch(url, {
                method: 'POST',
                body: formData
                
            }).then(response => response.json())
                .then(body => {
                    Swal.fire(
                        'URL has been shortened! Copy link below and save or click OK to shorten another URL',
                        `<a href="/api/shorturl/${body[3]}" target="_blank">http://${location.host}:/api/shorturl/${body[3]}</a>`,
                        'success'
                    )
                })
        }
    }})
