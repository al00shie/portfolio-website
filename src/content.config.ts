import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const projects = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/projects' }),
  schema: z.object({
    title: z.string(),
    order: z.number(),
    featured: z.boolean().default(true),
    tagline: z.string(),
    summary: z.string(),
    school: z.string(),
    credential: z.string(),
    course: z.string(),
    year: z.string(),
    role: z.string(),
    collaborators: z.array(z.string()).default([]),
    methods: z.array(z.string()).default([]),
    repo: z.string().url().optional(),
    repoLabel: z.string().optional(),
    paper: z.string().optional(),
    liveDemo: z.string().url().optional(),
    image: z.string(),
    imageAlt: z.string(),
  }),
});

export const collections = { projects };
