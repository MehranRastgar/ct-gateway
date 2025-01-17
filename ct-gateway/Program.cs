using Ocelot.DependencyInjection;
using Ocelot.Middleware;
using Microsoft.Extensions.Logging;

var builder = WebApplication.CreateBuilder(args);

// Add Ocelot configuration from ocelot.json
builder.Configuration.AddJsonFile("ocelot.json", optional: true, reloadOnChange: true);

// Register Ocelot services
builder.Services.AddOcelot(builder.Configuration);

// Build the application
builder.Services.AddCors(options =>
{
    options.AddPolicy("CorsPolicy", builder =>
    {
        builder.WithOrigins(["http://localhost:3026",
        "https://localhost:3000",
        "https://192.168.8.103:3000",

         "http://localhost:3000", "https://*.bugtech.ir","https://bugtech.ir", "https://cms.bugtech.ir"]) // origins
             .AllowAnyMethod()
             .AllowAnyHeader()
             .AllowCredentials();
    });
});
var app = builder.Build();
// Add a health check endpoint
app.MapGet("/health", () => Results.Ok(new { Status = "Healthy", Timestamp = DateTime.UtcNow }));

// Configure the HTTP request pipeline
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
else
{
    app.UseExceptionHandler("/Home/Error"); // Handle errors in production
    app.UseHsts(); // Use HTTP Strict Transport Security
}
app.UseCors("CorsPolicy");
// Use Ocelot middleware as the last step
app.UseOcelot().Wait();

app.Run();
