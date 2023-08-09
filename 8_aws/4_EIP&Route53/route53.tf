## 이폴더는 실행시키지 않을것임

resource "aws_route53_zone" "example" {
  name = "example.com"
}

resource "aws_route53_record" "server1-record" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "server1.example.com"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.server1.public_ip}"]
}

resource "aws_route53_record" "server2-record" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "server2.example.com"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.server2.public_ip}"]
}

resource "aws_route53_record" "mail1-recourd" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "mail1.example.com"
  type    = "A"
  ttl     = "300"
  records = [
    #....... 메일 서버의 공인 IP 주소
  ]
}

output "ns-servers" {
  value = aws_route53_zone.example.name_servers
}

