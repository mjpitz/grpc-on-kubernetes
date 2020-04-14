# Headless Service

[![service.png](service.png)](service.png)

Be mindful when consuming headless services.
Cloud providers often charge an additional fee for communicating across availability zones.
Since DNS isn't topology aware, resolved addresses may exist in a different AZ.
