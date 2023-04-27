
use actix_web::{get, App, HttpServer, HttpResponse, Responder, http::header};


#[get("/hello")]
async fn hello() -> impl Responder {
    return HttpResponse::Ok()
        .append_header((header::CONTENT_TYPE, header::ContentType::html()))
        .body("<b1>Hello World</b1><br><br><div>chortle</div>");
}

#[actix_web::main]
async fn main() -> std::io::Result<()>{
    return HttpServer::new(|| {
        App::new()
            .service(hello)

    })
    .bind("0.0.0.0:8080")?
    .run()
    .await;
}
