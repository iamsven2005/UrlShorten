let app = new Vue({
    el: '#app',
    data: {
        input: '',
    },

    methods: {
        post: function(event) {
            const url = '/api/shorten/new'
            const orig = this.input
            let formData = new URLSearchParams()

            formData.append('long-url', orig)

            return fetch(url, {
                method: 'POST',
                body: formData

            }).then(response=>{
                if (response.ok) {
                    return response.json()
                } else {
                    throw new Error('error')
                }
            }).then(body=>{
                Swal.fire('URL has been shortened! Copy link below and save or click OK to shorten another URL', `<a href="/api/shorturl/${body.shortUrl}" target="_blank">http://${location.host}:/api/shorturl/${body.shortUrl}</a>`, 'success')
            }
                   ).catch(error => {
                       console.log(error)
                   })
        }
    }
})

