use std::time::Duration;

use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn my_function(_input: ()) {}

fn bench_example(c: &mut Criterion) {
    let mut group = c.benchmark_group("One");
    group.measurement_time(Duration::from_secs(10));

    #[allow(clippy::unit_arg)]
    group.bench_function("Process One", |b| b.iter(|| my_function(black_box(()))));

    group.finish();
}

criterion_group!(benches, bench_example);
criterion_main!(benches);
