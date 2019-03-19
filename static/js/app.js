let app = new Vue({
    el: '#app',
    data: {
        input: 'Type your URL to be shortened here..'
    },

    methods: {
        post: function (event) {
            const url = '/api/shorten/new'
            const orig = this.input
            let formData = new URLSearchParams()
            
            formData.append('long-url', orig)

            return fetch(url, {
                method: 'POST',
                //headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
                body: formData
                
            }).then(presp => presp.json())
                .then(resp => console.log(resp))
        }
    }})
