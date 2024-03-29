 var _ = require('lodash'); 
function Product(name="", description="", price=1, brand="", quantity=1, 
                date=new Date(), reviews=[], images=[], activeSize="",
                sizes=['XS', 'S', 'M', 'L', 'XL', 'XXL']){
    this.sizes       = sizes;
    this.name        = name;
    this.description = description;
    this.price       = +price;
    this.brand       = brand;
    this.quantity    = +quantity;
    this.date        = date;
    this.reviews     = reviews;
    this.images      = images;
    this.activeSize  = activeSize;
    this.id          = +new Date()+""; 
    
    let getProps = ["Name", "Description", "Price",
                    "ID", "Brand", "Sizes", "ActiveSize",
                    "Quantity", "Date", "Reviews", "Images"];  
    let setProps = ["ActiveSize", "Date", "Brand", "Price", "Description", "Name"]          
    
    //Get Props def
    let defineGetProps = (properties = getProps) => {
        for(let prop of properties) 
        Object.defineProperty(this, "get"+prop, { value: () => this[prop.toLowerCase()] });
    }
    defineGetProps();
    
    this.getReviewByID = (id) => this.reviews.find(r => r.ID === id);
    this.getImage = (imgName) => imgName ? this.images.find(img => img === imgName) : this.images[0];
    
    //Add props def
    let defineAddProps = (properties = ["Sizes", "Reviews"]) => {
        for(let prop of properties) 
            Object.defineProperty(this, "add"+prop.slice(0, -1), { value: (el) => this[prop.toLowerCase()].includes(el) ? this[prop.toLowerCase()] : this[prop.toLowerCase()].push(el)  });
    }
    defineAddProps();
    
    //Set props def
    let defineSetProps = (properties = setProps) => {
        for(let prop of properties){
            prop == "ActiveSize" 
                 ? Object.defineProperty(this, "set"+prop, { value: (el) => this.sizes.includes(el) ? this[prop.toLowerCase()] = el : this[prop.toLowerCase()] })
                 : Object.defineProperty(this, "set"+prop, { value: (el) => this[prop.toLowerCase()] = el });
        }
    }
    defineSetProps();
    

    this.deleteReview = (id) => this.reviews = this.reviews.filter(r => r.ID !== id)

    this.deleteSize = (that) => this.sizes = this.sizes.filter(size => size !== that)
    this.getAverageRating = () => _.meanBy(this.reviews, r => r.rating.value)
}
let args = ["Lodka", "Veslovat' ochen' veselo", 900, "LodDka", 5, /*time*/ ,[{ID:1, author: "kek", date: new Date(), comment: "some comment", rating: {service:4, price:43, value: 10, quality: 2} }],["url/img1", "url/img2"]]

let p = new Product(...args);

console.log(p.getName());
console.log(p.getDescription());
console.log(p.getSizes());
console.log(p.getQuantity());
console.log(p.getReviewByID(1).comment);
console.log(p.getImage("url/img1"));
console.log(p.addSize("XXS"));
console.log(p.getSizes());
console.log(p.deleteSize("M"));
console.log(p.getSizes());
console.log(p.getAverageRating());


let searchProducts = (products, query) => {
    products.filter(p => p.getName.includes(query)  || p.getDescription.includes(query))
}
let sortProducts = (products, sortRule = "price") => {
    if (sortRule === "price" || sortRule === "id")
        products.sort((a,b) => parseFloat(a[sortRule])-parseFloat(b[sortRule]))
    if (sortRule == "name")
        products.sort((a,b) => ( a[sortRule] > b[sortRule] ) ? 1 : -1)
}
