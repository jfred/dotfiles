# Java

## Todo

## Issues

## Aliases

`mpath` - exports CLASSPATH from maven pom

Assumes that the dependency plugin is setup

    ...
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-dependency-plugin</artifactId>
                <version>2.5.1</version>
            </plugin>
        </plugins>
    </build>
    ...
