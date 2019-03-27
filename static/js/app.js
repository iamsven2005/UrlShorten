let popupSuccess = (response) => {
    return Swal.fire(
        'URL has been shortened!',
        `<a href="/api/shorturl/${response.shortUrl}" 
         target="_blank">http://${location.host}/api
         /shorturl/${response.shortUrl}</a>`,
        'success'
    )
}

let popupError = (response) => {
    return Swal.fire(
        `Error: ${response.error}`,
        'Your submission was invalid. Please try again with valid http(s) URL later.',
        'error'
    )
}

let app = new Vue({
    el: '#app',
    data: {
        urlInput: '',
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

            }).then(response => response.json())
                .then(response => {
                    if ("error" in response) {
                        popupError(response)
                    }
                    
                    else {
                        popupSuccess(response)
                    }
                })
        }
    }
})

