# Tabinin

## Nomad front end

View jobs and information for [Nomad](http://nomadproject.io) clusters

### Viewing all jobs

![Jobs View](https://github.com/shokunin/tabinin/blob/master/docs/jobs_all.png)

### Viewing a specific job

![Jobs View](https://github.com/shokunin/tabinin/blob/master/docs/job_example.png)

### Viewing all nodes

![Nodes View](https://github.com/shokunin/tabinin/blob/master/docs/nodes_all.png)

### Viewing node information

![Node View](https://github.com/shokunin/tabinin/blob/master/docs/node2.png)

### Viewing cluster usage

![Stats View](https://github.com/shokunin/tabinin/blob/master/docs/stats.png)

## Running 

To run as a nomad job:

```
job "tabinin" {
  datacenters = ["testdc"]
  type = "service"
  update {
    stagger = "10s"
    max_parallel = 1
  }
  group "tabinin" {
    count = 2
    restart {
      attempts = 10
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }
    task "tabinin" {
      driver = "docker"
      config {
        image = "maguec/tabinin:latest"
        force_pull = true
        port_map {
          tabinin = 4000
        }
      }
      resources {
        cpu    = 400 # 500 MHz
        memory = 256 # 256MB
        network {
          mbits = 10
          port "tabinin" {}
        }
      }
      env {
         NOMAD_API      = "http://nomad.service.testdc:4646"
         NOMAD_CLUSTER  = "testdc"
      }
      service {
        name = "tabinin"
        tags = ["private-web-service"]
        port = "tabinin"
        check {
          name     = "alive"
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
```
