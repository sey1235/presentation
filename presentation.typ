
#import "@preview/polylux:0.3.1": *
#import themes.metropolis: *

#show: metropolis-theme.with(footer: [Java capstone project])

#set text(font: "Fira Sans", size: 20pt)
// #show code: set text(font: "Fira Math")
#set strong(delta: 100)
#set par(justify: true)

#title-slide(
  author: [Seyon Srikantha, Jürgen Theodor Wawro],
  title: "Java Capstone Project",
  date: "2024-11-28",
)

#slide(title: "Table of contents")[
  #metropolis-outline
]

#new-section-slide([General overview])

#slide(title: "Assignments")[
  TODO???
]

#slide(title: "Project structure")[

]


#new-section-slide("Simulation")

#slide(title: "Overview")[
  - Simple input/output based simulation
  - Input: User defined simulation
  - Output: A directory with logs and results of the simulation
  - Datetime based, allows kind of realistic simulation of Solar Power
  - Simulation definition: Start, end, list of devices
]

#slide(title: "Devices")[
  #figure(
    image("diagrams/devices.svg"),
  )
]

#slide(title: "Running simulation")[
  - Tick based system(1 tick = 1hour)
  - Device tick output depends on current time
    and the state of the device
  - Runs between a datetime of start/end
  - Takes power from grid if not enough
    from saved power
  - Can contribute power to grid
]


#new-section-slide([I/O])

#slide(title: "Logger")[
  - Scalable realistic actor based lock-free logging
  - One virtual thread per actor
  - Message queue for synchronization
  - Close-safe implementation, atomic writes

  #pause

  But did it make sense for the purpose of this project?

  #pause

  No. This isn’t a real system and just a simulation.
  Still interesting to implement.
]

#slide(title: "Logging format")[
  - Files named after day timestamp with device name
  - Logging line format customizable
  - Injectable TimestampGenerator
  - Structured logging
  - Depending on line format log easy to parse (ex. JsonLines)
]

#slide(title: "Actors")[
  - Message queue running on a single virtual thread
  - Can receive fire and forget messages (tell) and messages which expect a reply (ask)
  - Matches the closes to the original definition of an "Object", unlike Java objects
  ```java
    final var mbox = new ArrayBlockingQueue<>(mboxCap);
    final var thread = Thread.ofVirtual().start(() -> {
      var active = true;
      while (active) {
        try {
          final var msg = mbox.take();
          if (msg instanceof Shutdown) {
            active = false;
            if (!a.handlesShutdown()) {
              break;
            }
          }
          a.handleMsg(me, msg);
        } catch (InterruptedException e) {
          active = false;
        } catch (UnhandledMessageException e) {
          System.out.println(e);
        }
      }
    });
  ```
]

#slide(title: "Logging implementation")[
  #figure(
    image("diagrams/logger.svg"),
  )
]

#slide(title: "Unit testing")[
  - Slightly incomplete
  - Easy to test classes are tested
  - Tests pass (Shown in live presentation)
]

#new-section-slide([UI])

#slide(title: "Web API")[
  - Javalin Web Framework
  - Simple JSON API using Gson
  - Entrypoint to submit simulations, list simulations
  - Can read logs of past simulations on demand
  - Every simulation running in own thread
]

#slide(title: "UI")[
  - Really MVP UI written with libcosmic
  - Can create new simulations
  - Can look up results of older simulations
  - Only tested on Linux, probably possible to compile for Windows
]

#slide[
  #figure(
    image("img/ui1.png"),
  )
]

#slide[
  #figure(
    image("img/ui2.png"),
  )
]

#slide(title: "Results")[
  Bare MVP project
  - Tick based simulation
  - Overengineered logging
  - Web API for easy integration with external systems
  - Working UI
]

#slide(title: "Outlook")[
  More realism
  - Currently energy production is kind of an arbitrary number

  Devices could be way more complex
  - Introduction of more context than a `Calendar`
  - SolarPanel could also take lat/lon in its tick method
    to calculate sun up/down

  Price could be calculated for drawing from grid
]

#new-section-slide([Live presentation])
