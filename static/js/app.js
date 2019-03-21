let jsonError = (response) => {
    if (response.status == 400) {
        throw new Error('probably user input was mistakenly submitted')
    }
}

let popupSuccess = (response) => {
    return Swal.fire(
        'URL has been shortened!',
        `<a href="/api/shorturl/${response.shortUrl}" 
         target="_blank">http://${location.host}:/api
         /shorturl/${response.shortUrl}</a>`,
        'success'
    )
}

let app = new Vue({
    el: '#app',
    data: {
        urlInput: ''
    },

    methods: {
        post: function(event) {
            const url = '/api/shorten/new'
            let longUrl = this.urlInput
            let requestParams = new URLSearchParams()

            requestParams.append('long-url', longUrl)

            return fetch(url, {
                method: 'POST',
                body: requestParams

            }).then(response => {
                jsonError(response)
                return response.json()
            }).then(response => {
                popupSuccess(response)
            }).catch(error => {
                console.log(error)
            })
        }
    }
})

