### Scale Sets


Mit den azurblauen Skalensätzen für virtuelle Maschinen können Sie eine Gruppe von lastverteilten VMs erstellen und verwalten. Die Anzahl der VM-Instanzen kann als Reaktion auf die Nachfrage oder einen definierten Zeitplan automatisch erhöht oder verringert werden. Skalierungssätze sorgen für eine hohe Verfügbarkeit Ihrer Anwendungen und ermöglichen Ihnen die zentrale Verwaltung, Konfiguration und Aktualisierung einer großen Anzahl von VMs. Mit Skalen-Sets für virtuelle Maschinen können Sie umfangreiche Services für Bereiche wie Compute-, große Daten- und Container-Workloads aufbauen.


### Availability Sets

Ein Verfügbarkeitssatz ist eine logische Gruppierungsfunktion zur Isolierung von VM-Ressourcen voneinander, wenn sie bereitgestellt werden. Azure stellt sicher, dass die VMs, die Sie in einem Availability Set platzieren, über mehrere physische Server, Compute-Racks, Speichereinheiten und Netzwerk-Switches laufen. Wenn ein Hardware- oder Softwarefehler auftritt, ist nur eine Teilmenge Ihrer VMs betroffen und Ihre Gesamtlösung bleibt betriebsbereit.

### Unterschiede
 
Der Hauptunterschied besteht darin, dass Scale-Sets identische VMs haben, wo in Verfügbarkeitssets nicht verlangt wird, dass sie identisch sind.
Die Bereitstellung neuer VMs in Azure bei Bedarf ist für Skalensätze einfacher, da alle anderen VMs in allen Aspekten identisch sind und eine Kopie einer Golden Copy darstellen.

Verfügbarkeitssätze dienen konzeptionell dazu, die Anwendungsverfügbarkeit zu verbessern, falls eine primäre VM ausfällt/aktualisiert werden muss, kann eine andere VM aus der Fehler-/Aktualisierungsdomäne bereitgestellt werden.

Skalensätze hingegen sind konzeptionell für die automatische Skalierung (horizontal) in Anwendungen konzipiert, bei denen die Belastung stark variieren kann, um mehr Rechenanforderungen zu erfüllen.

### Scale Set erstellen

- Namenskonvention Definieren
- Menge an Vms definieren.
- Low Priority einstellen (falls VMs nicht sehr wichtig sind)
- Eviction Policy einstellen
- Load Balancing option auswählen
- Rules für autoscaling einstellen (Manual/Schedule/Metrics)

### Low-priority VM Scale Sets

- Macht sich ungenüzte Computer Leistung zugute
- Gut für Arbeitsschritte die ausfähle vertragen können
- VMs können immer evakuirt werden
- Eviction Policy frei wählbar